// This function draws labels and values for the master control table

void masterLabelsAndValues() {
    float tlx = masterTable.topLeftX;
    float tly = masterTable.topLeftY;
    float tlh = masterTable.tableHeight;
    
    // LABELS
    text(" Volume",   tlx,
                     tly - 25,
                     tlx + masterTable.subSliderSize,
                     tly - 25);
                     
    text(" DryWet",   tlx + 1 * masterTable.subSliderSize,
                     tly - 25,
                     tlx + 2 * masterTable.subSliderSize,
                     tly - 25);

    text("  Size", tlx + 2 * masterTable.subSliderSize,
                     tly - 25,
                     tlx + 3 * masterTable.subSliderSize,
                     tly - 25);
    text("  Pan",      tlx + 3 * masterTable.subSliderSize,
                     tly - 25,
                     tlx + 4 * masterTable.subSliderSize,
                     tly - 25);
   
    text("   " + round(100 * parameters[PAR_VOL]) / 100.0,
                     tlx,
                     tly + + tlh,
                     tlx + masterTable.subSliderSize,
                     tly + tlh);
    text("   " + round(100 * parameters[PAR_DW]) / 100.0,
                     tlx + 1 * masterTable.subSliderSize,
                     tly + tlh,
                     tlx + 2 * masterTable.subSliderSize,
                     tly + tlh);
    text("   " + round(100 * parameters[PAR_RS]) / 100.0,
                     tlx + 2 * masterTable.subSliderSize,
                     tly + tlh,
                     tlx + 3 * masterTable.subSliderSize,
                     tly + tlh);
    text("   " + round(100 * parameters[PAR_PAN]) / 100.0,
                     tlx + 3 * masterTable.subSliderSize,
                     tly + tlh,
                     tlx + 4 * masterTable.subSliderSize,
                     tly + tlh);                    
}
