classdef PQ2 < handle

    properties
        nElements
        indx;
        priorityList;
        valueList;
    end

    methods
        function thePQueue = PQ2(n)
            thePQueue.nElements = 0;
            thePQueue.priorityList = nan(n,1);
            thePQueue.valueList{500} = [];

            thePQueue.indx = 1;
            thePQueue.nElements = 0;
        end

        function push(thePQueue, value, priority)
            thePQueue.priorityList(thePQueue.indx) = priority;
            thePQueue.valueList{thePQueue.indx} = value;
            thePQueue.indx = thePQueue.indx + 1;
            thePQueue.nElements = thePQueue.nElements + 1;
        end


        function minPriorityElement = pop(thePQueue)
            if ~thePQueue.isEmpty
                thePQueue.nElements = thePQueue.nElements - 1;
                [~, minPriorityIndx] = min(thePQueue.priorityList);
                minPriorityElement = thePQueue.valueList{minPriorityIndx};

                thePQueue.priorityList(minPriorityIndx) = NaN;
            else
                disp('Queue is empty');
            end
        end

        function flagIsEmpty = isEmpty(thePQueue)
        flagIsEmpty = (thePQueue.nElements == 0);
        end
    end
end