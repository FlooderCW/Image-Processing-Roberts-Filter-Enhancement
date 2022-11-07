function img_g = roberts(img, T, LG, LB, mode)
%
% The Roberts Gradient convolution masks for edge enhancement system.
%
%  img_r = roberts(img);
%
%  inputs:
%      img  ->  the input image array
%      T    ->  the nonnegative threshold
%      LG   ->  the specific gray level of edges
%      LB   ->  the specific gray level of background
%      mode ->  the selective mode for five different techniques of
%       gradient image
%           mode = 1:   g(x,y) = G[f(x,y)]
%           mode = 2:   g(x,y) = G[f(x,y)], if G >= T;
%                              = f(x,y), otherwise
%           mode = 3:   g(x,y) = LG, if G >= T;
%                              = f(x,y), otherwise
%           mode = 4:   g(x,y) = G[f(x,y)], if G >= T;
%                              = LB, otherwise
%           mode = 5:   g(x,y) = LG, if G >= T;
%                              = LB, otherwise
%
%  outputs:
%      img_r    ->  the output edge enhanced image array
%
    % default parameters if only given input image array
    if nargin == 1
        T = 25;
        LG = 255;
        LB = 0;
        mode = 1;
    end

    % Robert's filter masks
    h1 = [1 0; 0 -1];
    h2 = [0 1; -1 0];

    % Expand 1 row and column preventing from edge distortion
    %   ->  now the img is row+1 * col+1
    img(end+1,:) = img(end-1, 1:end);
    img(:,end+1) = img(1:end, end-1);

    % length of img columns and rows
    len_row = length(img(1,:)) -1;   % img is expanded, subtract by 1 for unnecessary process
    len_col = length(img(:,1)) -1;

    % define output image array
    img_g = zeros(len_row, len_col);

    % Filtering
    for i = 1:len_row
        for j = 1:len_col
            x = img(i:i+1, j:j+1);
            
            % convolution
            x1 = 0;
            x2 = 0;
            for n1 = 1:2
                for n2 = 1:2
                    x1 = x1 + x(n1,n2)*h1(n1,n2);
                    x2 = x1 + x(n1,n2)*h2(n1,n2);
                end
            end
            val = (x1.^2 +x2.^2).^0.5;

            switch mode
                %           mode = 1:   g(x,y) = G[f(x,y)]
                %           mode = 2:   g(x,y) = G[f(x,y)], if G >= T;
                %                              = f(x,y), otherwise
                %           mode = 3:   g(x,y) = LG, if G >= T;
                %                              = f(x,y), otherwise
                %           mode = 4:   g(x,y) = G[f(x,y)], if G >= T;
                %                              = LB, otherwise
                %           mode = 5:   g(x,y) = LG, if G >= T;
                %                              = LB, otherwise
                case 1
                    img_g(i,j) = val;
                case 2
                    if val >= T
                        img_g(i,j) = val;
                    else
                        img_g(i,j) = img(i,j);
                    end
                case 3
                    if val >= T
                        img_g(i,j) = LG;
                    else
                        img_g(i,j) = img(i,j);
                    end
                case 4
                    if val >= T
                        img_g(i,j) = val;
                    else
                        img_g(i,j) = LB;
                    end
                case 5
                    if val >= T
                        img_g(i,j) = LG;
                    else
                        img_g(i,j) = LB;
                    end
            end
        end
    end
return