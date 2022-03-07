load('Sokolov.mat');
I = double(SokolovTIF);
X = reshape(I,size(I,1)*size(I,2),109);
X = min(X,1); % this operation is to truncate values beyond maximal reflectance values (pay attention to values of the 83th band
X = max(X,0); % this operation is to truncate values beyond minimal reflectance values
X = specNormalize(X);

covX = cov(X);
IsDiag=eye(109)==1;
covX(IsDiag)=NaN; % getting rid of diagonal levels pointing to variance
[minval,minpos]=min(covX(:));  % min value and position in covariance matrix
i_min=fix(1+((minpos-1)/size(covX,1))) % index of column of min
j_min=minpos-(i_min-1)*size(covX,1) % index of raw of min
[maxval,maxpos]=max(covX(:)); % max value and position in correlation matrix
i_max=fix(1+((maxpos-1)/size(covX,1)))% index of column of max
j_max=maxpos-(i_max-1)*size(covX,1) % index of raw of max

corrX = corr(X);
corrX(IsDiag)=NaN; 
[minvalcorr,minposcorr]=min(corrX(:)); 
i_min_corr=fix(1+((minposcorr-1)/size(corrX,1))) 
j_min_corr=minposcorr-(i_min_corr-1)*size(corrX,1) 
[maxvalcorr,maxposcorr]= max(corrX(:)); 
i_max_corr=fix(1+((maxposcorr-1)/size(corrX,1))) 
j_max_corr=maxposcorr-(i_max_corr-1)*size(corrX,1) 

figure, 
subplot (2,2,1), 
scatter(X(:,i_min),X(:,j_min)), title('Bands with minimal covariance'); xlabel(['Band' num2str(i_min)]); ylabel(['Band' num2str(j_min)]); 
subplot (2,2,2), 
scatter(X(:,i_max),X(:,j_max)), title('Bands with maximal covariance'); xlabel(['Band' num2str(i_max)]); ylabel(['Band' num2str(j_max)]); 
subplot (2,2,3), scatter(X(:,i_min_corr),X(:,j_min_corr)), title('Bands with minimal correlation'); xlabel(['Band' num2str(i_min_corr)]); ylabel(['Band' num2str(j_min_corr)]); 
subplot (2,2,4), scatter(X(:,i_max_corr),X(:,j_max_corr)), title('Bands with maximal correlation'); xlabel(['Band' num2str(i_max_corr)]); ylabel(['Band' num2str(j_max_corr)]); 
% after you build the scatters, add to each of them �axis([0 1 0 1],'square')� to see better what is going on
