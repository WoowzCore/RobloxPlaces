-- By Woowz11

--!strict
--!optimize 2
--!native

_G.Other = {

    -- Try/Catch, пример: _G.Other.Try(function() error("ERROR") end):Catch(function(e) print(e) end)
    Try = function(Function : () -> any) : {}
        local Try = {}

        function Try:Catch(Catcher : (any) -> any)
            local S, E = xpcall(Function, function(Message) return debug.traceback(Message) end)
            if not S then return Catcher(E) end
            return E
        end
        
        return Try
    end,

    -- Сдвигает время
    TimeOffset = function(Time : {}, Hour : number) : {}
        local Result = table.clone(Time)
        Result.hour += Hour

        if Result.hour >= 24 then
            Result.hour -= 24
            Result.day += 1

            local DaysInMouth
            if Result.mouth == 2 then
                if (Result.year % 4 == 0 and Result.year % 100 ~= 0) or (Result.year % 400 == 0) then
                    DaysInMouth = 29
                else
                    DaysInMouth = 28
                end
            elseif Result.mouth == 4 or Result.mouth == 6 or Result.mouth == 9 or Result.mouth == 11 then
                DaysInMouth = 30
            else
                DaysInMouth = 31
            end

            if Result.day > DaysInMouth then
                Result.day = 1
                Result.mouth += 1
                if Result.mouth > 12 then
                    Result.mouth = 1
                    Result.year += 1
                end
            end
        end

        return Result
    end,

    -- Округляет до указаных десятичных
    Round = function(Number : number, Digits : number) : number
        local Multiplier = 10 ^ Digits
        return math.floor(Number * Multiplier + 0.5) / Multiplier
    end

}

return nil