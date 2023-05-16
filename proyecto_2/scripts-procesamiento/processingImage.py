from PIL import Image
import numpy as np
import imageio
import math

def resizeImage(path):
    """
    resizeImage(path): redimensiona una imagen .jpg para que sea de tamaño 300x300 
    para propósitos de procesamiento de la asip.
    ----------
    Parámetros: 
        path: ruta de la imagen
    
    return: void
    """
    img = Image.open(path)
    img = img.resize((width,hsize), Image.LANCZOS)
    img.save(path)

def rgbToGray(path):
    """
    rgbToGray(path): convierte una imagen rgb a escala de grises 
    para aplicarle la transformación lineal.
    ----------
    Parámetros: 
        path: ruta de la imagen
    
    return: void
    """
    resizeImage(path=path)
    rgb_matrix = np.array(imageio.imread(path), dtype='int').tolist()
    print("RGB: ", len(rgb_matrix))
    grayscale = []
    for y in range(hsize):
        for x in range(width):
            data = rgb_matrix[y][x]
            data_av = (data[0]+data[1]+data[2])//3
            grayscale.append(data_av)
    return grayscale

# Aplicar la transformación lineal a cada valor de la lista
def linear_transformation(width:int, hsize:int, Lx:int, Ly:int, gray_list:list, out_path)-> list:
    """
    linear_transformation: aplica una transformación lineal a la lista de píxeles en gray_list
    en un rango de 2 a 16 con pasos de 2 en 2 (sujeto a cambios). 
    ----------
    Parametros: 
        width       : int, ancho de la imagen
        hsize       : int, alto de la imagen
        Lx          : int, periodo de transformación a coordenada X
        Ly          : int, periodo de transformación a coordenada Y
        gray_list   : list, lista con pixeles de imagen
    return: transformed_list, lista con valores nuevos
    """
    for k in range(2, 16, 2):
        transformed_list = []
        Ax = k
        Ay = k
        for i in range(len(gray_list)):
            x = i % width
            y = i // width
            xnew = math.floor((x + Ax * math.sin(2 * math.pi * y / Lx)))% width
            ynew = math.floor((y + Ay * math.sin(2 * math.pi * x / Ly)))% hsize
            index = ynew * width + xnew
            transformed_list.append(gray_list[index])

        pic = Image.new('L', (width, hsize))
        pic.putdata(transformed_list)

    # Guardar la imagen
        pic.save(f"{out_path}gray_barbara_transformed{k}.jpg")
        pic.close()

if __name__ == "__main__":
    image_path = "scripts-procesamiento/barbara.jpg"
    width, hsize = 300, 300
    print(width)
    Lx = 80
    Ly = 80
    gray_list = rgbToGray(image_path)
    out_path = "scripts-procesamiento/out/"
    linear_transformation(width, hsize, Lx, Ly, gray_list, out_path)