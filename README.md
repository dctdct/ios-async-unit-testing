Asynchrones Unit Testing mit NSOperation und Blocks unter iOS im Rahmen eines gekapselten Service-Model-Layer (Objective C)
======================

Das Testen von asynchronen Klassen bzw. Methoden ist eine spannende und je nach Technologie herausfordernde Aufgabenstellung. Im folgenden Blogbeitrag möchte ich Strategien mit Objective C unter iOS aufzeigen. Dazu habe ich eine Demo-App implementiert, welche meinen RSS Blog Feed runterlädt und in der Debug Console ausgibt. Da das UI nicht blockieren soll während der Download läuft (Responsive), greife ich bei der Implementierung auf die beiden Klassen NSOperationQueue und NSOperation zurück. Diese ermöglichen bestimmte Aufgaben asynchron im Hintergrund auszuführen. 

