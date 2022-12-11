classdef monkey < handle
    properties
        number
        items
        operationFun
        operationCon
        testCons
        trueResult
        falseResult
        inspected
    end

    methods
        function obj = monkey(input)
            obj.number = input(1).double();
            obj.items = input(2).split(", ").double()';
            ops = input(3).split(" ");
            switch ops(1)
                case "*"
                    obj.operationFun = @(x,y) x * y;
                case "/"
                    obj.operationFun = @(x,y) x / y;
                case "+"
                    obj.operationFun = @(x,y) x + y;
                otherwise
                    obj.operationFun = @(x,y) x - y;
            end
            obj.operationCon = ops(2);
            obj.testCons = input(4).extractAfter(" by ").double();
            obj.trueResult = input(5).double();
            obj.falseResult = input(6).double();
            obj.inspected = 0;
        end

        function [location, worryLevel] = locationToSendItem(obj,modder)
            idx = 1;
%           obj.items(idx) is worry level
            if obj.operationCon == "old"
                operationDoub = obj.items(idx);
            else
                operationDoub = obj.operationCon.double();
            end
            obj.items(idx) = obj.operationFun(obj.items(idx),operationDoub);
%             obj.items(idx) = floor(obj.items(idx)/3);
            if mod(obj.items(idx), obj.testCons) == 0
                location = obj.trueResult;
            else
                location = obj.falseResult;
            end
            location = location + 1;
            worryLevel = obj.items(idx);
            obj.items(idx) = [];
            obj.inspected = obj.inspected + 1;

            worryLevel = mod(worryLevel,modder);
        end
        function addItem(obj,worryLevel)
            obj.items = [obj.items worryLevel];
        end
    end

end