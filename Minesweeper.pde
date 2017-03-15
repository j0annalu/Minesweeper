

import de.bezier.guido.*;
private int NUM_ROWS =20; 
private int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];    
    for (int row = 0; row < NUM_ROWS; row++){
        for (int column = 0; column < NUM_COLS; column++){
            buttons[row][column] = new MSButton(row, column);
        }
    }
        setBombs();
        //System.out.println(buttons[19][19].isValid(19,20));
}
public void setBombs()
{
    //int test = 0;
    int row;
    int column;
    for (int i = 0; i < 50; i++){
        row = (int)(Math.random()*20);
        column = (int)(Math.random()*20);
        if (!bombs.contains(buttons[row][column]))
        {
            {bombs.add(buttons[row][column]);}
            //System.out.println(row + ", " + column);
        }
            //test++;
    //System.out.println(row + "," + column);    
    }

}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    fill(255,0,0);
    text("YOU LOSE", 200, 200);
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if (keyPressed == true && marked == false)
            marked = true;
        else if (keyPressed == true && marked == true)
            marked = false;
        else if (bombs.contains(this))
            {
                displayLosingMessage();
            }
        else if (countBombs(r, c) > 0)
            setLabel(""+countBombs(r,c));
        else 
            {
                //System.out.println(r + ", " + c);
                if (isValid(r+1,c) == true && buttons[r+1][c].isClicked() == false)
                    buttons[r+1][c].mousePressed();
                //System.out.println("after first if");
                if (isValid(r+1,c+1) == true && buttons[r+1][c+1].isClicked() == false)
                    buttons[r+1][c+1].mousePressed();
                //System.out.println("after second if");
                if (isValid(r+1,c-1) == true && buttons[r+1][c-1].isClicked() == false)
                    buttons[r+1][c-1].mousePressed();
                //System.out.println("after third if");
                if (isValid(r,c+1) == true && buttons[r][c+1].isClicked() == false)
                    buttons[r][c+1].mousePressed();
                //System.out.println("after fourth if");
                if (isValid(r,c-1) == true && buttons[r][c-1].isClicked() == false)
                    buttons[r][c-1].mousePressed();
                //System.out.println("after fifth if");
                if (isValid(r-1,c-1) == true && buttons[r-1][c-1].isClicked() == false)
                    buttons[r-1][c-1].mousePressed();
                //System.out.println("after sixth if");
                if (isValid(r-1,c) == true && buttons[r-1][c].isClicked() == false)
                    buttons[r-1][c].mousePressed();
                //System.out.println("after seventh if");
                if (isValid(r-1,c+1) == true && buttons[r-1][c+1].isClicked() == false)
                    buttons[r-1][c+1].mousePressed();
                //System.out.println("after eighth if");
    }
}

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if (isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if (isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if (isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if (isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if (isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if (isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if (isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        
        return numBombs;
    }
}



