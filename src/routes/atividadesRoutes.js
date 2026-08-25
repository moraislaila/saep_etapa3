import { Router } from 'express';
import { getAtividades } from '../controllers/atividadesController.js';

const router = Router();

router.get('/', getAtividades);

export default router;
