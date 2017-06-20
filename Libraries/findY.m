function y = findY(angleKnee, x, Lul, Lll)
y = sqrt(Lul^2 + Lll^2+2 .* Lul.* Lll .*cos(angleKnee)-x.^2);
end

