format long g

function result = validate_input(Ui, R)
    num_columns_Ui = size(Ui, 2);
    length_R = length(R);
    result = iscolumn(R) && (num_columns_Ui ==( length_R - 1));
end

function Ua = invertAddierer(Ui, R)
% Funktion invertAddierer
% Autor: Henri Schulz
% Erstellungsdatum: 08.11.24
% Beschreibung: Berechnet die Ausgangsspannung eines invertierenden Addierers
% Input: Matrix Ui (Dimension n, m);
%        Vektor R (Dimension n+1, 1);
% Output: Vektor Ua (Dimension m, 1);
    if ~validate_input(Ui, R)
        error("Die Dimensionen stimmen nicht überein!")
    end

    [m,n] = size(Ui);
    RN = R(end);
    Ua = zeros(m, 1);

    for j = 1:n
        Ua= Ua - (RN / R(j)) * Ui(:, j);
    end



end


t = (linspace(0, 1, 2001)./ 1000)';



f_U1 = 1e3; %(Hz also 1kHz)
f_U2 = 2e3; %(Hz also 2kHz)
f_U3 = 3e3; %(Hz also 3kHz)

amplitude = 5; %V

U1 = amplitude * sin(2 * pi * f_U1 * t);
U2 = amplitude * sin(2 * pi * f_U2 * t);
U3 = amplitude * sin(2 * pi * f_U3 * t);

Ui = [U1, U2, U3];

R1 = 10e3; %Ohm -> 10kOhm
R2 = 15e3; %Ohm -> 15kOhm
R3 = 20e3; %Ohm -> 20kOhm
RN = 5e3; %Ohm -> 5kOhm

R = [R1, R2, R3, RN]';

Ua = invertAddierer(Ui, R)

%size(Ui, 2)
%length(R)
%
%size(Ui, 2)  == (length(R)-1)


% use subplot for two vertical plots in a figure
% plot on the top one: U1 (label 1kHz) U2 (2kHz), U3 (3kHz) over time,

% plot on the bottom: Ua over time

subplot(2, 1, 1);

plot(t, U1, 'r', t, U2, 'g', t, U3, 'b');

legend('U1 (1kHz)', 'U2 (2kHz)', 'U3 (3kHz)');

xlabel('Zeit [s]');

ylabel('Spannung [V]');

title('Eingangsspannungen');
grid on;

subplot(2, 1, 2);

plot(t, Ua, 'm');

xlabel('Zeit [s]');

ylabel('Spannung [V]');

title('Ausgangsspannung');












