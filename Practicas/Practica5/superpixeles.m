%Cargamos el archivo con el volumen de imagenes 
storedStructure = load('01_CHAVE.mat');
%Leemos una de las imagenes 
aux=storedStructure.volumenes(:,:,1);
%Transformamos sus valores a escala de grises
img=mat2gray(aux);
originalImg=img;

%Recortamos imagen de manera interactiva
img=imcrop(img);

%Aplicamos superpixeles
[L,N]=superpixels(img,20);
BW= boundarymask(L);
imshow(imoverlay(img,BW,'cyan'))
 
%Obtenemos el histograma para cada superpixel y hacemos el promedio
%para obtener uno representativo
props=regionprops(L, img, 'PixelValues');

edges = 0:1/N:1;
numedges = length(edges);
counts= zeros(numedges-1, N);

for k = 1 : length(props)
    values = props(k).PixelValues;
    counts(:,k)=histcounts(values,edges);
end

mainHist=mean(counts);
%bar(edges(1:end-1), mainHist)



%Aplicamos superpixeles a la imagen original
[L_org,N_org]=superpixels(originalImg,600);
BW_org= boundarymask(L_org);
%imshow(imoverlay(originalImg,BW_org,'cyan'))

props_org=regionprops(L_org, originalImg, 'PixelValues');

outputImage = zeros(size(originalImg),'like',originalImg);
idx = label2idx(L_org);

for k=1:length(props_org)
    values_org = props_org(k).PixelValues;
    hist_org=histcounts(values_org,edges);
    value=get_chi_distance(mainHist,hist_org);

    Idx=idx{k};

    if (value<1000)  
        outputImage(Idx)=1;
    else
        outputImage(Idx)=mean(originalImg(Idx));
    end 
end

imshow(outputImage)

