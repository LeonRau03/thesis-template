from graphviz import Digraph

dot = Digraph(comment="frag.jetzt Request Path (vertical)", format="png")
dot.attr(rankdir="TB")  # Top to Bottom for vertical layout
dot.attr(nodesep="0.4", ranksep="0.5")

dot.node("User", "Nutzer\n(Browser / PWA)")
dot.node("PWA", "Angular Frontend\n(PWA)")
dot.node("NGINX", "WebSocket-Gateway\n(NGINX)")
dot.node("Backend", "Spring Boot Backend")
dot.node("Keycloak", "Keycloak\nIdentity Service")
dot.node("DB", "PostgreSQL")
dot.node("MQ", "RabbitMQ")
dot.node("KI", "KI-Backend\n(FastAPI / LangChain)")
dot.node("LLM", "Externe LLM-API")

dot.edge("User", "PWA")
dot.edge("PWA", "NGINX")
dot.edge("NGINX", "Backend")
dot.edge("Backend", "Keycloak")
dot.edge("Backend", "DB")
dot.edge("Backend", "MQ")
dot.edge("MQ", "KI")
dot.edge("KI", "LLM")
dot.edge("KI", "Backend")

output_path = dot.render("/mnt/data/fragjetzt-request-path-vertical")
output_path