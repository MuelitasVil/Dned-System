import { useState } from "react";
import { LoginForm } from "../components/LoginForm";
import type { LoginCredentials } from "../types/auth.types";
import styles from "./LoginPage.module.css";

/** Vista de integración. Todavía NO autentica ni crea una sesión. */
export function LoginPage() {
  const [notice, setNotice] = useState("");

  async function handleLogin(_credentials: LoginCredentials) {
    // Siguiente paso: llamar a modules/auth/api/auth.api.ts (Organizacional).
    // El backend debe verificar credenciales y crear la sesión.
    setNotice("Formulario validado. Falta conectar el endpoint de autenticación de Organizacional.");
  }

  return (
    <div className={styles.page}>
      <div className={styles.content}>
        <LoginForm
          onSubmit={handleLogin}
          onAuxiliaryAction={(action) => {
            setNotice(action === "reset-password"
              ? "La recuperación de contraseña aún no está configurada."
              : "La solicitud de acceso aún no está configurada.");
          }}
        />
        {notice && <p className={styles.notice} role="status">{notice}</p>}
      </div>
    </div>
  );
}
