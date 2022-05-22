import os
import pandas as pd
import numpy as np
import sklearn as sk
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import matplotlib
import shap
import umap
import scipy
from umap import UMAP
import matplotlib.pyplot as plt


diretorio = "/bitnami/projects/case_plusoft/dados_limpos.csv"
dados_municipais = pd.read_csv(diretorio, sep = ";")
dados_municipais.describe().transpose()
dados_municipais.columns

## Reducing dimensionality ##

dados_municipais_numericFeatures = dados_municipais[
	[ 
	   'Densidade_demográfica_2000', 'Distância_à_capital_km_',
       'Esperança_de_vida_ao_nascer_2000',
       'Mortalidade_até_um_ano_de_idade_2000',
       'Taxa_de_fecundidade_total_2000',
       'Percentual_de_pessoas_de_25_anos_ou_mais_analfabetas_2000',
       'Renda_per_Capita_2000', 'Índice_de_Gini_2000',
       'Intensidade_da_indigência_2000', 'Intensidade_da_pobreza_2000',
       'Índice_de_Desenvolvimento_Humano_Municipal_2000',
       'Taxa_bruta_de_freqüência_à_escola_2000', 'Taxa_de_alfabetização_2000',
       'Média_de_anos_de_estudo_das_pessoas_de_25_anos_ou_mais_de_idade_2000',
       'População_de_25_anos_ou_mais_de_idade_1991',
       'População_de_25_anos_ou_mais_de_idade_2000',
       'População_de_65_anos_ou_mais_de_idade_1991',
       'População_de_65_anos_ou_mais_de_idade_2000', 'População_total_1991',
       'População_total_2000', 'População_urbana_2000',
       'População_rural_2000'
    ]
].values

dados_municipais_scaled = StandardScaler().fit_transform(dados_municipais_numericFeatures)

emb5 = redim5.fit_transform(dados_municipais_scaled)
emb10 = redim10.fit_transform(dados_municipais_scaled)
emb15 = redim15.fit_transform(dados_municipais_scaled)
emb20 = redim20.fit_transform(dados_municipais_scaled)
emb100 = redim100.fit_transform(dados_municipais_scaled)

plot5_umap = plt.scatter(emb5[:,0], emb5[:,1])
plt.savefig("emb5")
plot10_umap = plt.scatter(emb10[:,0], emb10[:,1])
plt.savefig("emb10")
plot15_umap = plt.scatter(emb15[:,0], emb15[:,1])
plt.savefig("emb15")
plot20_umap = plt.scatter(emb20[:,0], emb20[:,1])
plt.savefig("emb20")
plot100_umap = plt.scatter(emb100[:,0], emb100[:,1])
plt.savefig("emb100")
s
min_dist = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
n_neighbors = [50,70,90,100,200,300,400,600,700,800,900,1000]
for i in min_dist:
	for j in n_neighbors:
		redim = umap.UMAP(n_neighbors = j, min_dist = i)
		emb = redim.fit_transform(dados_municipais_scaled)
		plot_umap = plt.scatter(emb[:,0], emb[:,1])
		plt.savefig("emb-{nbors}-dist-{dist}.png".format(dist = i, nbors = j))


dados_municipais_numericFeatures.shape
dados_municipais_scaled.shape
embeddings.shape

pd.DataFrame(embeddings)
plt.title('UMAP embedding of random colours');

class Minhacamada(tf.keras.layers):
	def __init__():
		super(self, Minhacamada)__init__()
		init_w = tf.initializers.RandomNormalInitializer()
		init_b = tf.initializers.RandomNormalInitializer()

		self.w = tf.Variable(init_w(shape), trainable = TRUE)
		self.b = tf.Variable(init_b(shape), trainable = TRUE)
	
	def build(self):	
	def call(self, input):
		self.input = input
		return(matmul(self.input, self.w ))+ self.b

modelo1 = tf.keras.Sequential([
		keras.layers.Dense(300)
		keras.layers.sigmoid(20)
		keras.layers.ReLU(20)
		keras.layers.Dense(300)
	])

modelo1.add_metric()
modelo1.add_los()
moedlo1.build()
