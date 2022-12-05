vs = getVerSum(op)


function out = getVerSum(in)
in
% while true

    isBottomLevel = all(cellfun(@isnumeric, in.child));
    if isBottomLevel
        out = sum(cell2mat(in.child))
        return
    else
        for idx = 1:numel(in.child)
%             if isnumeric(in.child{idx})
%                 continue
%             end
            in.child{idx} = getVerSum(in.child{idx});
        end
    end
% end
end