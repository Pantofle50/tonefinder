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
## @deftypefn {} {@var{retval} =} generateToneTable (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Fujitsu <Fujitsu@FUJITSU-NTB>
## Created: 2021-05-19

function [TONES] = generateToneTable (f_low_E)
  
  tone_names = {"E "; "F ";"F#"; "G ";"G#"; "A ";"A#"; "B ";"C "; "C#";"D "; "D#"};
  
  string = cellstr("");
  TONES = repmat(string,45,1);

  %Octave 2
  for i = 1:8
    
      TONES(i,2) = 2^((i-1)*100/1200) * f_low_E;
      TONES(i,1) = strcat(TONES(i,1),tone_names(i));
  endfor
  end_index = i;
  
  %Octave 3
  tn_offset = 9;
  tn_index = tn_offset;
  for i = 1:12
      TONES(i+end_index,2) = 2^((i+end_index-1)*100/1200) * f_low_E;;
      
      if (tn_index > length(tone_names))
              tn_index = 1;
      endif

      TONES(i+end_index,1) = tone_names(tn_index);
      tn_index++;
  endfor
  end_index += i;
  
  %Octave 4
  tn_offset = 9;
  tn_index = tn_offset;
  for i = 1:12
      TONES(i+end_index,2) = 2^((i+end_index-1)*100/1200) * f_low_E;;
      
      if (tn_index > length(tone_names))
              tn_index = 1;
      endif

      TONES(i+end_index,1) = tone_names(tn_index);
      tn_index++;
  endfor
  end_index += i;
  
  %Octave 5
  tn_offset = 9;
  tn_index = tn_offset;
  for i = 1:12
      TONES(i+end_index,2) = 2^((i+end_index-1)*100/1200) * f_low_E;;
      
      if (tn_index > length(tone_names))
              tn_index = 1;
      endif

      TONES(i+end_index,1) = tone_names(tn_index);
      tn_index++;
  endfor
  end_index += i;
  
    %Octave 6
  tn_offset = 9;
  tn_index = tn_offset;
  for i = 1:1
      TONES(i+end_index,2) = 2^((i+end_index-1)*100/1200) * f_low_E;;
      
      if (tn_index > length(tone_names))
              tn_index = 1;
      endif

      TONES(i+end_index,1) = tone_names(tn_index);
      tn_index++;
  endfor
  end_index += i;

endfunction
