
fileName = 'dataset1.json'; % filename in JSON extension
fid = fopen(fileName); % Opening the file
raw = fread(fid,inf); % Reading the contents
str = char(raw'); % Transformation
global data;
data = jsondecode(str);

%parse dataset
words=string.empty;%empty list to put the each pattern in 
targets=string.empty;%empty list to put the each tag in
%outputs=strings([size(data(1).intents,1),1]);%an array to contain all the tags
for j=1:size(data,1)%number of intents 
    for i=1:size(data(j).intents,1)%number of tags in each intent 
        for x=1:size(data(j).intents(i).patterns,1)%number of patternts in each tag 
                words(size(words,2)+1)=data(j).intents(i).patterns(x);%list with all words in the dataset
                targets(size(targets,2)+1)=data(j).intents(i).tag;% tag for each word in the dataset
        end  
    end
end 
document=preprocessText(words);%tokenize the words in the dataset
global documentencode;
documentencode=wordEncoding(document)%encode the words
%making the documents all in the same length
documentLengths = doclength(document);%lenght of each documnt
sequncelength=max(doclength(document));%most of the documents have 4 tokens  but i want to incluse all the data
inputs=doc2sequence(documentencode,document,'Length',sequncelength);
inputs=reshape(inputs,[size(inputs,2),size(inputs,1)]);
% %output targets
targets=categorical(targets);
numofclass=onehotencode(targets,1);
targets=reshape(targets,[size(targets,2),size(targets,1)]);
%network Architecture
inputSize = 1;
embeddingDimension = 100;
numHiddenUnits = 100;

numWords = documentencode.NumWords;
numClasses = size(numofclass,1);

layer=sequenceInputLayer(1,'Name','input')
lgraph = layerGraph(layer)
Block = [ 
    wordEmbeddingLayer(embeddingDimension,numWords,'Name','wordEmbedding')
    lstmLayer(numHiddenUnits,'OutputMode','last','Name','lstm layer')
    fullyConnectedLayer(numClasses,'Name','fully connected')
    softmaxLayer('Name','soft max')
    classificationLayer('Name','output layer')];
lgraph=addLayers(lgraph,Block);
lgraph = connectLayers(lgraph,'input','wordEmbedding');
figure
plot(lgraph)
title("Network Architecture")
options = trainingOptions('adam', ...
     'MaxEpochs',80, ...
    'MiniBatchSize',16, ...
    'GradientThreshold',2, ...
    'Shuffle','every-epoch', ...
    'Verbose',false);
global net;
net = trainNetwork(inputs,targets,lgraph,options);









