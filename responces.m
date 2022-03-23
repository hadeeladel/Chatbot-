function [flagGo, responce]=responces(text)
global documentencode;
global net;
global data
global flagGo
    test=preprocessText(text);
    testinput1=doc2sequence(documentencode,test,'Length',6);
    testinput1=reshape(testinput1,[size(testinput1,2),size(testinput1,1)]);
    labelsNew = char(classify(net,testinput1))
    for j=1:size(data,1);%number of intents 
    for i=1:size(data(j).intents,1);%number of tags in each intent
        temp=data(j).intents(i).tag;
        if strcmp(temp,labelsNew)
            x = randi(size(data(j).intents(i).responses,1));
            responce=char(data(j).intents(i).responses(x));
            if strcmp(labelsNew,'goodbye')
                flagGo=false; 
            end
        break 
        end 
    end
    end
end