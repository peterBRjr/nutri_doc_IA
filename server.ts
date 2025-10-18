
import 'dotenv/config';
import multer from 'multer';import express, { Request, Response, Application } from 'express';
import { generateMealAnalysis, NutriDoctorAnalysis } from './gemini-chat'; 

const app: Application = express();
const port: number = process.env.PORT ? parseInt(process.env.PORT, 10) : 3000;

const storage = multer.memoryStorage();
const upload = multer({ 
  storage: storage,
  limits: { fileSize: 10 * 1024 * 1024 }
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.post('/api/analise', upload.single('imagem'), async (req: Request, res: Response) => {
  
  if (!req.file) {
    return res.status(400).json({ erro: 'Nenhum arquivo de imagem enviado.' });
  }

  try {
    const base64Image = req.file.buffer.toString('base64');

    console.log('Enviando imagem para análise da IA...');
    const analysis: NutriDoctorAnalysis = await generateMealAnalysis(base64Image);
    console.log('Análise recebida com sucesso.');

    return res.status(200).json(analysis);

  } catch (error) {
    console.error('Erro no endpoint /api/analise:', error);
    const errorMessage = error instanceof Error ? error.message : 'Erro desconhecido no servidor';
    return res.status(500).json({ erro: 'Falha ao analisar a imagem.', detalhes: errorMessage });
  }
});

app.get('/', (req: Request, res: Response) => {
  res.send('Serviço web Nutri Doctor está no ar! Use POST /api/analise para testar.');
});
app.listen(port, () => {
  console.log(`🚀 Servidor Nutri Doctor rodando em http://localhost:${port}`);
});