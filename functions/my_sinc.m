% l'ho aggiunta perché a quanto pare per usare la sinc 
% di matlab bisogna avere una licenza che non ho da quello che ho capito
% se voi ce l'avete si può anche eliminare

function y = my_sinc(x)
    y = ones(size(x));
    idx = x ~= 0;
    y(idx) = sin(pi*x(idx)) ./ (pi*x(idx));
end
