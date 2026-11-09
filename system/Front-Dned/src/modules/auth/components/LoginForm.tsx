import { useState } from "react";
import type { FormEvent } from "react";
import type { LoginCredentials } from "../types/auth.types";
import styles from "./LoginForm.module.css";

type LoginFormProps = {
  onSubmit: (credentials: LoginCredentials) => void | Promise<void>;
  onAuxiliaryAction?: (action: "reset-password" | "request-access") => void;
};

type FieldErrors = Partial<Record<"email" | "password", string>>;

function validate(credentials: LoginCredentials): FieldErrors {
  const errors: FieldErrors = {};
  if (!credentials.email.trim()) {
    errors.email = "El correo electrónico es obligatorio.";
  } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(credentials.email.trim())) {
    errors.email = "Introduce un correo electrónico válido.";
  }
  if (!credentials.password) {
    errors.password = "La contraseña es obligatoria.";
  } else if (credentials.password.length < 6) {
    errors.password = "La contraseña debe tener al menos 6 caracteres.";
  }
  return errors;
}

export function LoginForm({ onSubmit, onAuxiliaryAction }: LoginFormProps) {
  const [credentials, setCredentials] = useState<LoginCredentials>({
    email: "",
    password: "",
    remember: false,
  });
  const [errors, setErrors] = useState<FieldErrors>({});
  const [showPassword, setShowPassword] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitError, setSubmitError] = useState("");

  function changeField(field: "email" | "password", value: string) {
    setCredentials((prev) => ({ ...prev, [field]: value }));
    setErrors((prev) => ({ ...prev, [field]: undefined }));
    setSubmitError("");
  }

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const nextErrors = validate(credentials);
    setErrors(nextErrors);
    if (Object.keys(nextErrors).length > 0) return;

    setIsSubmitting(true);
    setSubmitError("");
    try {
      await onSubmit({ ...credentials, email: credentials.email.trim() });
    } catch {
      // Evitar mostrar los detalles internos de una respuesta de autenticación.
      setSubmitError("No fue posible iniciar sesión. Inténtalo de nuevo.");
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <section className={styles.card} aria-labelledby="login-title">
      <header className={styles.header}>
        <h1 id="login-title">Iniciar sesión</h1>
        <p>Ingresa tus credenciales para acceder a Organizacional</p>
      </header>

      <form className={styles.form} onSubmit={handleSubmit} noValidate>
        <div className={styles.field}>
          <label htmlFor="login-email" className={styles.visuallyHidden}>Correo electrónico</label>
          <input
            id="login-email"
            name="email"
            type="email"
            autoComplete="username"
            placeholder="Correo electrónico"
            value={credentials.email}
            onChange={(event) => changeField("email", event.target.value)}
            aria-invalid={Boolean(errors.email)}
            aria-describedby={errors.email ? "login-email-error" : undefined}
            disabled={isSubmitting}
          />
          {errors.email && <p id="login-email-error" className={styles.error}>{errors.email}</p>}
        </div>

        <div className={styles.field}>
          <label htmlFor="login-password" className={styles.visuallyHidden}>Contraseña</label>
          <div className={styles.passwordWrapper}>
            <input
              id="login-password"
              name="password"
              type={showPassword ? "text" : "password"}
              autoComplete="current-password"
              placeholder="Contraseña"
              value={credentials.password}
              onChange={(event) => changeField("password", event.target.value)}
              aria-invalid={Boolean(errors.password)}
              aria-describedby={errors.password ? "login-password-error" : undefined}
              disabled={isSubmitting}
            />
            <button
              type="button"
              className={styles.togglePassword}
              onClick={() => setShowPassword((value) => !value)}
              aria-label={showPassword ? "Ocultar contraseña" : "Mostrar contraseña"}
              aria-pressed={showPassword}
              disabled={isSubmitting}
            >
              {showPassword ? (
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" aria-hidden="true">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M3 3l18 18M10.58 10.59a2 2 0 002.83 2.82" />
                  <path strokeLinecap="round" strokeLinejoin="round" d="M9.88 5.2A10 10 0 0112 5c4.5 0 8.3 2.7 10 7a11 11 0 01-3.17 4.57M6.6 6.6C4.5 7.76 2.9 9.6 2 12c1.7 4.3 5.5 7 10 7a10.2 10.2 0 004.2-.9" />
                </svg>
              ) : (
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" aria-hidden="true">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12Z" />
                  <circle cx="12" cy="12" r="3" />
                </svg>
              )}
            </button>
          </div>
          {errors.password && <p id="login-password-error" className={styles.error}>{errors.password}</p>}
        </div>

        <div className={styles.options}>
          <label className={styles.remember}>
            <input
              type="checkbox"
              checked={credentials.remember}
              onChange={(event) => setCredentials((prev) => ({ ...prev, remember: event.target.checked }))}
              disabled={isSubmitting}
            />
            Recordarme
          </label>
          <button
            type="button"
            className={styles.textAction}
            onClick={() => onAuxiliaryAction?.("reset-password")}
          >
            ¿Olvidaste tu contraseña?
          </button>
        </div>

        {submitError && <p className={styles.submitError} role="alert">{submitError}</p>}
        <button className={styles.submitButton} type="submit" disabled={isSubmitting}>
          {isSubmitting ? <><span className={styles.spinner} aria-hidden="true" />Ingresando...</> : "Iniciar sesión"}
        </button>
      </form>

      <p className={styles.footer}>
        ¿No tienes acceso?{" "}
        <button type="button" className={styles.textAction} onClick={() => onAuxiliaryAction?.("request-access")}>
          Solicitar acceso
        </button>
      </p>
    </section>
  );
}
