## Copyright (C) 2021 Fujitsu
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} findFreq (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Fujitsu <Fujitsu@FUJITSU-NTB>
## Created: 2021-05-16

function [f_max amp f spectrum] = findFreq (rawAudio, lim, fs, N_FFT)
  
% Get FFT of the audio 
fft_w = fft(rawAudio, N_FFT);
fft_w = fft_w(1:length(fft_w)/2);
fft_w = abs(fft_w);

fft_w = fft_w(1:lim);

% Define the frequency axis
f = 0:fs/N_FFT:fs-fs/N_FFT;
f = f(1:length(f)/2);

f = f(1:lim);

% Find maximum in the FFT image
fft_max = 0;
n_max = 1;
fft_min_level = 30;
fft_downslope_cntr = 0;

f_guitar_max = 1050;
f_guitar_min = 80;

%for i = 1:length(fft_w)
%  
%  if fft_w(i)>fft_max
%    fft_max = fft_w(i);
%    n_max = i;
%    i_max = i_max + 1;
%  endif
%
%endfor

i = 1;

while ((fft_downslope_cntr < 5) && (i < (length(fft_w)-1)))

  if ((fft_w(i) > fft_min_level) && (f(i) > f_guitar_min) && (f(i) < f_guitar_max))
  
    if (fft_w(i) > fft_max)
      fft_max = fft_w(i);
      n_max = i;
    endif
       
    if ((fft_w(i+1) - fft_w(i)) < 0)
      fft_downslope_cntr++;
    endif
  
  endif
  
  i++;
endwhile

f_max = f(n_max);
spectrum = fft_w;
amp = spectrum(n_max);
f = f;
endfunction
