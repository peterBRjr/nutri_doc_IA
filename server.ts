
import 'dotenv/config'; // <-- ADICIONE ESTA LINHA
import multer from 'multer';import express, { Request, Response, Application } from 'express';
import { generateMealAnalysis, NutriSnapAnalysis } from './gemini-chat'; 

const app: Application = express();
const port: number = process.env.PORT ? parseInt(process.env.PORT, 10) : 3000;

const storage = multer.memoryStorage();
const upload = multer({ 
  storage: storage,
  limits: { fileSize: 10 * 1024 * 1024 }
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// --- Rota Principal da API ---
// O Flutter vai enviar a foto para este endpoint.
// 'upload.single('imagem')' é o middleware do Multer que procura
// por um campo chamado 'imagem' no 'multipart/form-data'.
app.post('/api/analise', upload.single('imagem'), async (req: Request, res: Response) => {
  
  // 2. Verificação de Segurança
  if (!req.file) {
    return res.status(400).json({ erro: 'Nenhum arquivo de imagem enviado.' });
  }

  try {
    // 3. Conversão Mágica
    // O 'req.file.buffer' é a imagem em bytes.
    // O 'gemini-chat.ts' espera uma string em base64.
    // Esta linha faz a conversão:
    const base64Image = req.file.buffer.toString('base64');

    // 4. Chamada à IA
    // Usamos a interface 'NutriSnapAnalysis' para tipar a resposta.
    console.log('Enviando imagem para análise da IA...');
    const analysis: NutriSnapAnalysis = await generateMealAnalysis(base64Image);
    console.log('Análise recebida com sucesso.');

    // 5. Sucesso!
    return res.status(200).json(analysis);

  } catch (error) {
    // 6. Tratamento de Erro
    console.error('Erro no endpoint /api/analise:', error);
    // Verifica se 'error' é um objeto Error padrão
    const errorMessage = error instanceof Error ? error.message : 'Erro desconhecido no servidor';
    return res.status(500).json({ erro: 'Falha ao analisar a imagem.', detalhes: errorMessage });
  }
});

// --- Rota de Teste (Opcional) ---
app.get('/', (req: Request, res: Response) => {
  res.send('API do NutriSnap está no ar! Use POST /api/analise para testar.');
});

// --- Inicialização do Servidor ---
app.listen(port, () => {
  console.log(`🚀 Servidor NutriSnap rodando em http://localhost:${port}`);
});