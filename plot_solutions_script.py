import pandas as pd
import matplotlib.pyplot as plt

# Charger le fichier CSV généré par votre C++
df = pd.read_csv("solutions_lorenz_euler.csv")

# Création d'une figure 3D
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(projection='3d')

# Tracer la trajectoire x, y, z
ax.plot(df['x'], df['y'], df['z'], lw=0.6, color='purple')

# Personnalisation du graphique
ax.set_title("Attracteur de Lorenz")
ax.set_xlabel("Axe X")
ax.set_ylabel("Axe Y")
ax.set_zlabel("Axe Z")

# 1. Sauvegarder D'ABORD (avec une bonne résolution grâce à dpi=300)
plt.savefig("solutions_lorenz_euler.png", dpi=300)

# 2. Afficher ENSUITE dans une fenêtre interactive
plt.show()
