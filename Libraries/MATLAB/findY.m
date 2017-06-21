function y = findY(angleKnee, x, Lul, Lll)
%For deriavation see: https://confluence.projectmarch.nl:8443/pages/viewpage.action?pageId=9438020
y = sqrt(Lul^2 + Lll^2+2 .* Lul.* Lll .*cos(angleKnee)-x.^2); %[m]
end

