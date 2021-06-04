function [out] = clsfy(C01, C02, P)
    %% Input
    % C01: nSub x nFeature -> Children age at 11
    % C02: nSub x nFeature -> Children age at 13
    % P: nSub x nFeature -> Parent
    %% Output
    % out.acc_c1p: Accuracy when we used children age at 11 and parents
    % out.acc_c2p: Accuracy when we used children age at 13 and parents
    % out.acc_c1c2: Accuracy when we used children age at 11 and children age at 13

    %% Parameters
    nsub = size(C01,1);
    disttype = 'correlation';
    
    %% Main
    dist12 = pdist2(C01,C02,disttype);
    acc_sub_c1c2 = sum(repmat(diag(dist12)',nsub,1) < dist12) ./ (nsub-1);
    acc_c1c2 = mean(acc_sub_c1c2);

    dist1 = pdist2(C01,P,disttype);
    acc_sub_c1p = sum(repmat(diag(dist1)',nsub,1) < dist1) ./  (nsub-1);
    acc_c1p = mean(acc_sub_c1p);

    dist2 = pdist2(C02,P,disttype);
    acc_sub_c2p = sum(repmat(diag(dist2)',nsub,1) < dist2) ./  (nsub-1);
    acc_c2p = mean(acc_sub_c2p);
    
    %% Save
    out.acc_c1p = acc_c1p;
    out.acc_c2p = acc_c2p;
    out.acc_c1c2 = acc_c1c2;
end
