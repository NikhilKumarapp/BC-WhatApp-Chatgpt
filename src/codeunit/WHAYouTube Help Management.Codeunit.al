// codeunit 83259 "YouTube Help Management"
// {
//     [EventSubscriber(ObjectType::Page, Page::"YouTube Help Part", 'OnAfterGetCurrentRecord', '', false, false)]
//     local procedure UpdateYouTubeContext(var RecRef: RecordRef)
//     var
//         YouTubeHelpPart: Page "YouTube Help Part";
//         PageID: Integer;
//         TableID: Integer;
//     begin
//         PageID := CurrPage.PageId;
//         TableID := RecRef.Number;
        
//         YouTubeHelpPart.SetContext(PageID, TableID);
//     end;
// }