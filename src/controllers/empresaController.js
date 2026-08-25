import pool from '../config/db.js';

const CALORIAS_CASE = `
  CASE LOWER(tipo_atividade)
    WHEN 'corrida' THEN duracap_min * 10
    WHEN 'ciclismo' THEN duracap_min * 8
    WHEN 'caminhada' THEN duracap_min * 5
    WHEN 'natação' THEN duracap_min * 9
    WHEN 'musculação' THEN duracap_min * 6
    WHEN 'musulação' THEN duracap_min * 6
    WHEN 'futebol' THEN duracap_min * 8
    ELSE duracap_min * 6
  END
`;

export const getEmpresa = async (req, res) => {
  try {
    const atividadesResult = await pool.query(`
      SELECT
        COUNT(*)::int AS total_atividades,
        COALESCE(SUM(${CALORIAS_CASE}), 0)::int AS total_calorias
      FROM atividades_table
    `);

    res.status(200).json({
      nome: 'SAEPSaúde',
      logo: null,
      total_atividades: atividadesResult.rows[0].total_atividades,
      total_calorias: atividadesResult.rows[0].total_calorias
    });
  } catch (err) {
    console.error('Erro ao buscar dados da empresa:', err);
    res.status(500).json({
      erro: 'Erro ao buscar dados da empresa',
      detalhe: err.message
    });
  }
};