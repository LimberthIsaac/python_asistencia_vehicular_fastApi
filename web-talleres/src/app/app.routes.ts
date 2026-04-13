import { Routes } from '@angular/router';
import { Landing } from './pages/landing/landing';
import { RegistroTaller } from './pages/registro-taller/registro-taller';
import { Dashboard } from './pages/dashboard/dashboard';

export const routes: Routes = [
  { path: '', component: Landing },
  { path: 'registro-taller', component: RegistroTaller },
  { path: 'dashboard', component: Dashboard },
  { path: '**', redirectTo: '' }
];
