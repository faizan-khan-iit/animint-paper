data(worldPop)
## Linked bar and line plots of world population by subcontinent,
## inspired by polychartjs.
viz <-
  list(bars=ggplot()+
       geom_bar(aes(x=subcontinent, y=population,
                    clickSelects=subcontinent, showSelected=year),
                data=worldPop, stat="identity", position="identity")+
       ## This make_text creates a geom_text that shows the current
       ## selected value of the year variable.
       make_text(worldPop, 1, 3e6, "year")+
       coord_flip(),
       lines=ggplot()+
       ## This make_tallrect tiles the background of the lineplot with
       ## rects that can be clicked to select the year variable.
       make_tallrect(worldPop, "year")+
       ## This geom_point does not have aes(clickSelects) so its alpha
       ## transparency behaves normally: all points have alpha=1/4.
       geom_point(aes(year, population, colour=type),
                  data=worldPop, size=4, alpha=1/4)+
       ## This geom_line DOES have aes(clickSelects) so only the
       ## selected line has the specified alpha=3/4. The other
       ## unselected lines have 0.5 less (alpha=1/4).
       geom_line(aes(year, population, group=subcontinent,
                     clickSelects=subcontinent),
                 data=worldPop, size=4, alpha=3/4),
       time=list(variable="year", ms=2000),
       duration=list(year=1000))
