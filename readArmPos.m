function [armAngles] = readArmPos(Serial)

    fprintf(Serial,'%s\r', 'QP 0 QP 1 QP 2 QP 3 QP 4');
    armAngles = fread(Serial,5,'uint8');
    armAngles = armAngles.*10;
    armAngles = armAngles';

end

