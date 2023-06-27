function info = processData(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
data = data{:};
info.date = datetime(data(1), "InputFormat","uuuu-MM-dd HH:mm");
info.event = data(2);
end

