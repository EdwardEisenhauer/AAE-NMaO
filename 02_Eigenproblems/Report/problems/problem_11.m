image=imread("student_rat.png");%load image
image=rgb2gray(image);%turn image to grayscale
image=(double(image))/255;%image pixel values between 0 and 1

[U,S,V]=svd(image);%
[R,C]=size(image);
S2=zeros(R,C);
for N=[10 20 40 60 80 100]
    for i=1:N
        S2(i,i)=S(i,i); %overwrite to create new sigma matrix
    end
    newImage=U*S2*V';%approximate image with new sigma
    figure;
    imshow(newImage);

end
