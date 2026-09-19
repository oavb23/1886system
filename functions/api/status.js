// Rota de teste: https://SEU-SITE.pages.dev/api/status
// Confirma que o back-end está no ar e se o banco D1 está conectado.
export async function onRequestGet({ env }) {
  let banco = "não conectado";
  if (env.DB) {
    try {
      await env.DB.prepare("SELECT 1").first();
      banco = "conectado";
    } catch (e) {
      banco = "erro: " + e.message;
    }
  }
  return Response.json({ sistema: "online", banco });
}
