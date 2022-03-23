global data;
global flagGo
for j=1:size(data,1)%number of intents 
    for i=1:size(data(j).intents,1)%number of tags in each intent
        temp=data(j).intents(i).tag;
        if strcmp(temp,'greeting')
            x = randi(size(data(j).intents(i).responses,1));
            first=char(data(j).intents(i).responses(x));
            flagGo=true; 
        end 
    end
end


    
    
