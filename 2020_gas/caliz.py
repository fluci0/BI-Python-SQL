# -*- coding: utf-8 -*-
"""
Created on Fri Jul 10 08:59:54 2020
@author: ElMaGo - flucio 
LABS
Script que muestra las precios promedios mensuales de la gasolina y el Diesel en México Ene2017-Mayo2020
Rev. 1.1
Fuente: Relación de precios de gasolina regular, gasolina premium y diesel por estación de servicio. 
Consultado en:
https://datos.gob.mx/busca/dataset/estaciones-de-servicio-gasolineras-y-precios-finales-de-gasolina-y-diesel
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.animation as animation
plt.style.use('dark_background')

df_data = pd.read_csv("CALIZ.csv")

font = {'family': 'sans-serif',
        'color':  'beige', #Aqua para 87octanos, coral para91 octanos y beige para Diésel
        'weight': 'bold',
        'size': 12,
        }

#colores = dict(zip(['Aguascalientes', 'B. C.', 'B.C. Sur'], ["\'r'", "\'r'", "\'r'"]))

colores = {'Aguascalientes' : '#adb0ff',
           'B. C.' : '#44bd32',
           'B.C. Sur' : '#adb0ff'}

watermark = plt.imread('LogoNECwhite.png')
fig1 = plt.figure(figsize=[13, 8])
ax = fig1.add_subplot(111)
ax.figure.figimage(watermark, 550, 350, alpha=.4, zorder=1)

#ax.barh(df_data.Entidad_Federativa, df_data.Gasolina_Min_87octanos, color= [colores for x in df_data['Entidad_Federativa']])
ax.barh(df_data.Entidad_Federativa, df_data.Gasolina_Min_87octanos, color= df_data['Entidad_Federativa'].replace(colores))