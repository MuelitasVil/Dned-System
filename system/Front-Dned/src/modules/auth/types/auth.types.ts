/** Datos capturados por el formulario; no son un token ni una sesión. */
export type LoginCredentials = {
  email: string;
  password: string;
  remember: boolean;
};
