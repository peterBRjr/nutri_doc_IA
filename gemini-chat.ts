
import { VertexAI, Part } from '@google-cloud/vertexai';

interface Ingrediente {
  nome: string;
  beneficios: string;
}
interface NutriDoctorAnalysis {
  criticaGourmet: string;
  ingredientes: Ingrediente[];
}

const PROJECT_ID = process.env.GOOGLE_PROJECT_ID || 'YOUR_PROJECT_ID';
const LOCATION = process.env.GOOGLE_LOCATION || 'YOUR_LOCATION';

const vertex_ai = new VertexAI({ project: PROJECT_ID, location: LOCATION });
const model = "gemini-2.0-flash";

const generativeModel = vertex_ai.preview.getGenerativeModel({
  model: model,
  generationConfig: {
    'maxOutputTokens': 2048,
    'temperature': 0.4,
    'topP': 1,
    'topK': 32,
  },
});
const analysisPromptText = `
Analise a imagem desta refeição e forneça uma resposta ESTRITAMENTE no seguinte formato JSON. Não adicione NENHUM texto, markdown ou formatação fora da estrutura JSON:

{
  "criticaGourmet": "...",
  "ingredientes": [
    {
      "nome": "...",
      "beneficios": "..."
    }
  ]
}

Instruções para o JSON:
1. "criticaGourmet": Gere um comentário divertido, criativo e curto (2-3 frases) sobre o prato, como um crítico gastronômico espirituoso.
2. "ingredientes": Liste os 3-5 principais alimentos visíveis na foto.
3. "nome": O nome do ingrediente (ex: "Salmão Grelhado", "Brócolis", "Arroz Branco").
4. "beneficios": Um resumo simples (1-2 frases) dos principais benefícios nutricionais desse ingrediente para a saúde.
`;
async function generateMealAnalysis(base64Image: string): Promise<NutriDoctorAnalysis> {
  if (!base64Image) {
    throw new Error('Nenhuma imagem (base64) fornecida.');
  }

  const imagePart: Part = {
    inlineData: {
      mimeType: 'image/jpeg',
      data: base64Image,
    },
  };


  const textPart: Part = {
    text: analysisPromptText,
  };

  const request = {
    contents: [{ role: 'user', parts: [imagePart, textPart] }],
  };

try {
    const response = await generativeModel.generateContent(request);
    const contentResponse = response.response;
    
    if (!contentResponse || 
        !contentResponse.candidates || 
        contentResponse.candidates.length === 0 ||
        !contentResponse.candidates[0].content ||
        !contentResponse.candidates[0].content.parts ||
        contentResponse.candidates[0].content.parts.length === 0 ||
        !contentResponse.candidates[0].content.parts[0].text) 
    {
      throw new Error('Resposta da IA inválida ou vazia.');
    }

    const rawResponseText = contentResponse.candidates[0].content.parts[0].text;

    const jsonMatch = rawResponseText.match(/\{[\s\S]*\}/);

    if (!jsonMatch || jsonMatch.length === 0) {
        console.error("Nenhum JSON válido encontrado na resposta da IA:", rawResponseText);
        throw new Error('Resposta da IA não continha um JSON válido.');
    }

    const cleanedJsonString = jsonMatch[0];
    const jsonData: NutriDoctorAnalysis = JSON.parse(cleanedJsonString);

    if (!jsonData.criticaGourmet || !jsonData.ingredientes) {
        throw new Error('JSON retornado pela IA não segue o formato esperado.');
    }

    return jsonData;

  } catch (error) {
    console.error('Erro ao chamar a API do Gemini:', error);
    throw new Error('Falha ao analisar a imagem.');
  }
}

export { generateMealAnalysis, NutriDoctorAnalysis, Ingrediente };