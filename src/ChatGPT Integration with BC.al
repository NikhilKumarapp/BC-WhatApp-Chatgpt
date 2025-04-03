codeunit 83256 "Gemini Integration with BC"
{
    procedure SendMessage(apiKey: Text; message: Text): Text
    var
        Client: HttpClient;
        Headers: HttpHeaders;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        json: JsonObject;
        contentsArray: JsonArray;
        contentObj: JsonObject;
        content: HttpContent;
        data: Text;
    begin
        // Gemini API expects a different structure
        contentObj.Add('role', 'user');
        contentObj.Add('parts', CreatePartsArray(message));
        contentsArray.Add(contentObj);
        
        json.Add('contents', contentsArray);
        
        // For Gemini 1.0 models, you would use something like:
        // json.Add('model', 'models/gemini-pro');
        // For Gemini 1.5 models:
        json.Add('model', 'models/Gemini 1.0 Pro');

        request.Method := 'POST';
        request.SetRequestUri('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=' + apiKey);
        
        Request.GetHeaders(Headers);
        content.WriteFrom(Format(json));

        content.GetHeaders(Headers);
        Headers.Remove('Content-Type');
        Headers.TryAddWithoutValidation('Content-Type', 'application/json');
        request.Content := content;

        Client.Send(request, response);

        if response.HttpStatusCode <> 200 then begin
            response.Content.ReadAs(data);
            Error('Error sending message to Gemini. HTTP Status Code: %1. Response: %2', response.HttpStatusCode, data);
        end;

        response.Content.ReadAs(data);
        data := ReadGeminiResponse(data);

        exit(data);
    end;

    local procedure CreatePartsArray(message: Text): JsonArray
    var
        partsArray: JsonArray;
        partObj: JsonObject;
    begin
        partObj.Add('text', message);
        partsArray.Add(partObj);
        exit(partsArray);
    end;

    local procedure ReadGeminiResponse(data: Text): Text
    var
        obj: JsonObject;
        candidates: JsonToken;
        candidate: JsonToken;
        content: JsonToken;
        parts: JsonToken;
        part: JsonToken;
        text: JsonToken;
        txt: Text;
        fullText: Text;
    begin
        obj.ReadFrom(data);
        
        if obj.Get('candidates', candidates) then
            if candidates.AsArray().Get(0, candidate) then
                if candidate.AsObject().Get('content', content) then
                    if content.AsObject().Get('parts', parts) then
                        if parts.AsArray().Get(0, part) then
                            if part.AsObject().Get('text', text) then
                                txt := text.AsValue().AsText();
        
        if txt <> '' then begin
        fullText := 'Gemini: ' + txt;
        InsertResponse(CopyStr(fullText, 1, 250)); // Ensure we don't exceed 250 chars
        exit(txt); // Return full text while storing truncated version
        end;
        
        exit('No response received from Gemini');
    end;

    procedure InsertResponse(ConVer: Text)
    var
        ChatGPTConver: Record "Chat GPT";
        LastLine: Integer;
    begin
        if ChatGPTConver.FindLast() then
            LastLine := ChatGPTConver."Entry No.";

        ChatGPTConver.Init();
        ChatGPTConver."Entry No." := LastLine + 1;
        ChatGPTConver.Message := ConVer;
        ChatGPTConver.Insert();
    end;
}