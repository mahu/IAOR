function D_f = descriptorExtract(boundary)
    D = boundary(:,2) + j*boundary(:,1);
    D_f = fft(D);
    D_f = D_f(1:min(24, size(D_f,1)));

    % translation
    D_f(1) = 0;
    %scale invar.
    D_f = D_f./abs(D_f(2));
    %orientation
    D_f = abs(D_f);
end

