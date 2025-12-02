import { Pool } from 'pg';
import 'dotenv/config';

const pool = new Pool({
      user: process.env.DB_USER || 'admin',
      host: process.env.DB_HOST || 'localhost',
      database: process.env.DB_NAME || 'nutridoctor',
      password: process.env.DB_PASS || 'admin123',
      port: 5432,
});

export const initDB = async () => {
      try {
            const client = await pool.connect();

            console.log('📦 Conectado ao PostgreSQL com sucesso!');

            await client.query('CREATE EXTENSION IF NOT EXISTS vector;');

            const createTableQuery = `
      CREATE TABLE IF NOT EXISTS TAB001_Usuarios (
        id SERIAL PRIMARY KEY,
        nome VARCHAR(50) NOT NULL,
        cpf VARCHAR(11) NOT NULL,
        data_nascimento DATE NOT NULL,
        senha VARCHAR(10) NOT NULL,
        criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        embedding vector(768)
      );
    `;
            await client.query(createTableQuery);
            console.log('✅ Tabela de usuários verificada/criada.');

            client.release();
      } catch (error) {
            console.error('❌ Erro ao iniciar o banco de dados:', error);
      }
};

export default pool;