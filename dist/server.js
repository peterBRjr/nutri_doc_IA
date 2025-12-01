"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const multer_1 = __importDefault(require("multer"));
const express_1 = __importDefault(require("express"));
const gemini_chat_1 = require("./gemini-chat");
const app = (0, express_1.default)();
const port = process.env.PORT ? parseInt(process.env.PORT, 10) : 3000;
const storage = multer_1.default.memoryStorage();
const upload = (0, multer_1.default)({
    storage: storage,
    limits: { fileSize: 10 * 1024 * 1024 }
});
app.use(express_1.default.json());
app.use(express_1.default.urlencoded({ extended: true }));
app.post('/api/analise', upload.single('imagem'), async (req, res) => {
    if (!req.file) {
        return res.status(400).json({ erro: 'Nenhum arquivo de imagem enviado.' });
    }
    try {
        const base64Image = req.file.buffer.toString('base64');
        console.log('Enviando imagem para análise da IA...');
        const analysis = await (0, gemini_chat_1.generateMealAnalysis)(base64Image);
        console.log('Análise recebida com sucesso.');
        return res.status(200).json(analysis);
    }
    catch (error) {
        console.error('Erro no endpoint /api/analise:', error);
        const errorMessage = error instanceof Error ? error.message : 'Erro desconhecido no servidor';
        return res.status(500).json({ erro: 'Falha ao analisar a imagem.', detalhes: errorMessage });
    }
});
app.get('/', (req, res) => {
    res.send('Serviço web Nutri Doctor está no ar! Use POST /api/analise para testar.');
});
app.listen(port, () => {
    console.log(`🚀 Servidor Nutri Doctor rodando em http://localhost:${port}`);
});
