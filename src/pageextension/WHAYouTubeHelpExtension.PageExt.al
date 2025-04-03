// pageextension 83256 "YouTube Help Extension" extends "Business Manager Role Center"
// {
//     layout
//     {
//         addafter("Favorite Accounts")
//         {
//             part(YouTubeHelp; "YouTube Help Part")
//             {
//                 ApplicationArea = All;
//                 Visible = ShowYouTubeHelp;
//             }
//         }
//     }

//     var
//         ShowYouTubeHelp: Boolean;
//         CurrentPageID: Integer;
//         CurrentTableID: Integer;

//     trigger OnOpenPage()
//     begin
//         ShowYouTubeHelp := true;
//     end;
// }
