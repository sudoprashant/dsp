[Sitting, ~, ~] = xlsread('sitting_new.csv'); % For Sitting
[Stairs, ~, ~] = xlsread('stairs.csv'); % For Stairs
[Walking, ~, ~] = xlsread('walking.csv'); % For Walking

sitting_x = Sitting(:,1); sitting_y = Sitting(:,2); sitting_z = Sitting(:,3);
stairs_x = Stairs(:,1); stairs_y = Stairs(:,2); stairs_z = Stairs(:,3);
walking_x = Walking(:,1); walking_y = Walking(:,2); walking_z = Walking(:,3);
function1=[];
function2=[];
function3=[];
for i = 1:150
    Window1_x = sitting_x((i*10-9):(i*10));
    Window1_y = sitting_y((i*10-9):(i*10));
    Window1_z = sitting_z((i*10-9):(i*10));
    [a, b, c, d, e, f, g, h, q] = FeatureVec(Window1_x, Window1_y, Window1_z);
    function1= [function1; [a b c d e f g h q]];
    Window2_x = stairs_x((i*10-9):(i*10));
    Window2_y = stairs_y((i*10-9):(i*10)); 
    Window2_z = stairs_z((i*10-9):(i*10));
    [a, b, c, d, e, f, g, h, q] = FeatureVec(Window2_x, Window2_y, Window2_z);
    function2= [function2; [a b c d e f g h q ]];
    Window3_x = walking_x(i*10-9:i*10);
    Window3_y = walking_y(i*10-9:i*10);
    Window3_z = walking_z(i*10-9:i*10);
    [a, b, c, d, e, f, g, h, q] = FeatureVec(Window3_x, Window3_y, Window3_z);
    function3= [function3; [a b c d e f g h q ]];
    
end
csvwrite('file11.csv',function1);
csvwrite('file22.csv',function2);
csvwrite('file33.csv',function3);