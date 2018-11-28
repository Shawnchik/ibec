function WriteFiles
% ファイルに書き込む
% Nomenclature%%%%%
% Results       :出力値の行列

global Results CalStep Results_Td_in_AAC Results_Td_out_AAC

% 二行目以降
if rem(CalStep + 1,7200) == 0
    i = (CalStep + 1) / 7200 - 1;
    if i < 10
        dlmwrite(['Result/OutputNo0',num2str(i),'.csv'],Results,'precision',8);
        dlmwrite(['Result_Td/Output_Td_in_AAC_No0',num2str(i),'.csv'],Results_Td_in_AAC,'precision',8);
        dlmwrite(['Result_Td/Output_Td_out_AAC_No0',num2str(i),'.csv'],Results_Td_out_AAC,'precision',8);
    else
        dlmwrite(['Result/OutputNo',num2str(i),'.csv'],Results,'precision',8);
        dlmwrite(['Result_Td/Output_Td_in_AAC_No',num2str(i),'.csv'],Results_Td_in_AAC,'precision',8);
        dlmwrite(['Result_Td/Output_Td_out_AAC_No',num2str(i),'.csv'],Results_Td_out_AAC,'precision',8);
    end
    Results = zeros(7200,46);
    Results_Td_in_AAC = zeros(7200,31);
    Results_Td_out_AAC = zeros(7200,31);
end
