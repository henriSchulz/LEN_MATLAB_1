function [power, efficiency] = VerbraucherLeistung(Ri,Rl, U0)
% Function VerbraucherLeistung
% Autor             : Henri Schulz
% Erstellungsdatum  : 07.11.24
% Beschreibung      : Berechnet die Leistung und den Wirkungsgrad eines Verbrauchers
% Input             : Skalar Ri (Dimension 1, 1);
%                        Vektor Rl (Dimension n, 1);
%                        Skalar U0 (Dimension 1, 1);
% Output            : Vektor Pl (Dimension n, 1);
%                     Vektor eff (Dimension n, 1);


    if ~validate_input(Ri, Rl, U0)
        error("Die Dimensionen stimmen nicht überein!");
    end
    power = calculate_power(Ri, Rl, U0);
    efficiency = calculate_efficiency(Ri, Rl);

    % Print results
    [M, I] = calculate_max_power(power);
    fprintf("Die maximale Leistung beträgt: %.2f W.\n", M);
    fprintf("Der Wirkungsgrad an diesem Punkt beträgt: %.2f %%.", efficiency(I));

end

function result = calculate_power(Ri, Rl, U0)
    Pl = zeros(length(Rl), 1);
    for i = 1:length(Rl)
        Pl(i) = (U0^2/(Ri+Rl(i))^2) * Rl(i);
    end
    result = Pl;
end
function result = calculate_efficiency(Ri, Rl)
    eff = zeros(length(Rl), 1);
    for i = 1:length(Rl)
        eff(i) = (Rl(i)/Ri)/(1+(Rl(i)/Ri));
        % convert to percentage
        eff(i) = eff(i) * 100;
    end

    result = eff;
end
function result = validate_input(Ri, Rl, U0)
    result = isscalar(Ri) && isscalar(U0) && iscolumn(Rl);
end
function [M, I] = calculate_max_power(Pl)
    [max_power, index] = max(Pl);
    M = max_power;
    I = index;
end




function void = plot_results()
    U0 = 20; % V
    Ri = 10; % Ohm
    Rl = (0:0.05:100)'; % Ohm[], length = 2001
    size(Rl)
    [Pl, eff] = VerbraucherLeistung(Ri, Rl, U0);
    x= [];
    for i = 1:length(Rl)
        x(i) = Rl(i)/Ri;
    end
    y1 = Pl;
    y2 = eff;
    figure(1)
    plot(x, y1, 'r', 'LineWidth', 2)
    xlabel('Widerstandverhältnis Rl/Ri [Ohm]')
    ylabel('Leistung im Verbraucher [W]')

    yyaxis right
    plot(x, y2, 'b', 'LineWidth', 2)
    ylabel('Wirkungsgrad [%]')
    legend('Leistung im Verbraucher', 'Wirkungsgrad')
title('Leistung im Verbraucher & Wirkungsgrad in Abhängigkeit des Widerstandverhältnisses')
    grid on
    hold on
end



plot_results()



















