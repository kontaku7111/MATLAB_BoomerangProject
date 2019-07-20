function gyroHdr=estimate_gyroHDR(yAcc)
    % yAcc (unit: m/(s^2))
    gyroHdr=-0.04005*yAcc.^2+24.65*yAcc+1228;
end