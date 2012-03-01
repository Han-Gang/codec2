% fdmdv_mod.m
%
% Modulator function for FDMDV modem.
%
% Copyright David Rowe 2012
% This program is distributed under the terms of the GNU General Public License 
% Version 2
%

function tx_fdm = fdmdv_mod(rawfilename, nbits)

fdmdv; % include modem code

frames = floor(nbits/(Nc*Nb));
tx_fdm = [];
gain = 1000; % Sccle up to 16 bit shorts

for i=1:frames
  tx_bits = get_test_bits(Nc*Nb);
  tx_symbols = bits_to_qpsk(tx_bits);
  tx_baseband = tx_filter(tx_symbols);
  tx_fdm = [tx_fdm fdm_upconvert(tx_baseband)];
end

tx_fdm *= gain;
fout = fopen(rawfilename,"wb");
fwrite(fout, tx_fdm, "short");