import pool from '../config/db.js';

export const getEmpresa = async (req, res) => {
  try {
    const atividadesResult = await pool.query(
      'SELECT COUNT(*)::int AS total_atividades FROM atividades_table'
    );

    res.status(200).json({
      nome: 'SAEPSaúde',
      logo: null,
      total_atividades: atividadesResult.rows[0].total_atividades,
      total_calorias: null
    });
  } catch (err) {
    console.error('Erro ao buscar dados da empresa:', err);
    res.status(500).json({
      erro: 'Erro ao buscar dados da empresa',
      detalhe: err.message
    });
  }
};
