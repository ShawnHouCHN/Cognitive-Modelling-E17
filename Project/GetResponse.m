function [Response, RT] = GetResponse()

%Define response keys - cf. KbDemo.md
KbName('UnifyKeyNames');
LeftKey = KbName('leftarrow');
RightKey = KbName('rightarrow');
EscKey = KbName('ESCAPE');

while KbCheck; end % guard against too early responses
ResponseGiven=0;
T1 = GetSecs;
while ~ResponseGiven
    [ keyIsDown, timeSecs, keyCode ] = KbCheck;
    if keyIsDown
        
        RT = timeSecs - T1;
        if keyCode(EscKey)
            YouHaveAbandonedTheProgramByPressingEscape
        end
        
        if keyCode(LeftKey)
            ResponseGiven=1;
            Response=1;
        end
        
        if keyCode(RightKey)
            ResponseGiven=1;
            Response=2;
        end
        
        while KbCheck; end %key must be released before another response can be given
    end
end
end