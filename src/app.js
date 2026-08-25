import express from 'express';
import cors from 'cors';
import statusRoutes from './routes/statusRoutes.js';
import empresaRoutes from './routes/empresaRoutes.js';
import atividadesRoutes from './routes/atividadesRoutes.js';

const app = express();

app.use(cors());
app.use(express.json());

app.use('/status', statusRoutes);
app.use('/empresa', empresaRoutes);
app.use('/atividades', atividadesRoutes);

export default app;
