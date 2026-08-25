import pool from '../config/db.js';

const TIPOS_PERMITIDOS = ['corrida', 'caminhada', 'trilha'];

export const getAtividades = async (req, res) => {
  try {
    const pagina = Math.max(parseInt(req.query.pagina, 10) || 1, 1);
    const limite = 4;
    const offset = (pagina - 1) * limite;
    const tipo = req.query.tipo?.toLowerCase();

    if (tipo && !TIPOS_PERMITIDOS.includes(tipo)) {
      return res.status(400).json({
        erro: 'Tipo de atividade inválido',
        tipos_permitidos: TIPOS_PERMITIDOS
      });
    }

    const params = [];
    let where = '';

    if (tipo) {
      params.push(tipo);
      where = 'WHERE LOWER(tipo_atividade) = $1';
    }

    const countResult = await pool.query(
      `SELECT COUNT(*)::int AS total FROM atividades_table ${where}`,
      params
    );

    const total = countResult.rows[0].total;
    const totalPaginas = Math.ceil(total / limite);

    params.push(limite, offset);

    const result = await pool.query(
      `SELECT
        a.id_atividade,
        a.usuario_id,
        u.nome AS usuario,
        a.tipo_atividade,
        a.distancia_km,
        a.duracap_min AS duracao_min,
        TO_CHAR(a.data_atividade, 'HH24:MI - DD/MM/YY') AS data_formatada,
        a.descricao
      FROM atividades_table a
      INNER JOIN usuarios_table u ON u.id_usuario = a.usuario_id
      ${where}
      ORDER BY a.data_atividade DESC, a.id_atividade DESC
      LIMIT $${params.length - 1} OFFSET $${params.length}`,
      params
    );

    return res.status(200).json({
      pagina,
      por_pagina: limite,
      total,
      total_paginas: totalPaginas,
      filtro_tipo: tipo || null,
      atividades: result.rows
    });
  } catch (err) {
    console.error('Erro ao buscar atividades:', err);
    return res.status(500).json({
      erro: 'Erro ao buscar atividades',
      detalhe: err.message
    });
  }
};
