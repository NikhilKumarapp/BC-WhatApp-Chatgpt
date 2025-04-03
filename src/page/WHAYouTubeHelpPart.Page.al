// page 83257 "YouTube Help Part"
// {
//     PageType = CardPart;
//     ApplicationArea = All;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             usercontrol(YouTubePlayer; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
//             {
//                 ApplicationArea = All;

//                 trigger ControlAddInReady()
//                 begin
//                     LoadYouTubeVideo();
//                 end;

//                 trigger DocumentReady()
//                 begin
//                     LoadYouTubeVideo();
//                 end;
//             }
//         }
//     }

//     var
//         VideoURL: Text;
//         CurrentPageID: Integer;
//         CurrentTableID: Integer;

//     procedure SetContext(PageID: Integer; TableID: Integer)
//     begin
//         CurrentPageID := PageID;
//         CurrentTableID := TableID;
//         LoadYouTubeVideo();
//     end;

//     local procedure LoadYouTubeVideo()
//     var
//         YouTubeVideo: Record "YouTube Video" temporary;
//         VideoID: Text;
//     begin
//         // Get the appropriate video ID based on context
//         VideoID := GetYouTubeVideoID(CurrentPageID, CurrentTableID);
        
//         if VideoID <> '' then begin
//             VideoURL := 'https://www.youtube.com/embed/' + VideoID + '?autoplay=0';
//             CurrPage.YouTubePlayer.SetContent(VideoURL);
//         end;
//     end;

//     local procedure GetYouTubeVideoID(PageID: Integer; TableID: Integer): Text
//     var
//         // You would typically have a table to map pages/tables to video IDs
//         PageYouTubeMapping: Record "Page YouTube Mapping";
//         TableYouTubeMapping: Record "Table YouTube Mapping";
//     begin
//         // First try to find a page-specific video
//         if PageYouTubeMapping.Get(PageID) then
//             exit(PageYouTubeMapping.VideoID);
            
//         // If no page-specific video, try to find a table-specific video
//         if TableID <> 0 then
//             if TableYouTubeMapping.Get(TableID) then
//                 exit(TableYouTubeMapping.VideoID);
                
//         // Default video if no specific one found
//         exit('dQw4w9WgXcQ'); // Replace with your default video ID
//     end;
// }
