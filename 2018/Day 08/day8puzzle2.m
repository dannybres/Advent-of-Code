%% day8puzzle2 - Daniel Breslan - Advent Of Code 2018
clc
data = readlines("input.txt").split(" ").double();

d = digraph; % diectional graph

[~,d] = process(data,d,"start"); % process it recuresively

% find weight of edge from "start"
day8puzzle2result = ...
    d.Edges.Weight(string(d.Edges.EndNodes(:,1)) == "start") 


function [data,d] = process(data,d,parent) 
% remaining string, graph, name of parent node
nodeName = string(char(65 + d.numnodes)); % get string name for node
d = d.addnode(nodeName); % add node
d = d.addedge(parent,nodeName,0); % and edge

nCh = data(1); % get num children
nMe = data(2); % get num meta
data = data(3:end); % dispose of header

for idx = 1:nCh % process childs recursively
    [data,d] = process(data,d,nodeName);
end

meta = data(1:nMe); % get meta (now children have finished)
data(1:nMe) = []; % dispose of meta

if nCh == 0 % if no children set weigh = to sum of meta, need to lookup 
    % edge of parent to nodeNAme
    d.Edges.Weight(string(d.Edges.EndNodes).join() == ...
        join([parent nodeName])) = sum(meta);
else
    % if childrem loop meta and add the value of children (if exist)
    allEdges = string(d.Edges.EndNodes);
    edgesFromHere = d.Edges(allEdges(:,1) == nodeName,:);
    nodeValue = 0;
    for midx = meta'
        if midx > height(edgesFromHere)
            continue
        else
            nodeValue = nodeValue + edgesFromHere.Weight(midx);
        end
    end
    d.Edges.Weight(string(d.Edges.EndNodes).join() == ...
        join([parent nodeName])) = nodeValue;
end
end